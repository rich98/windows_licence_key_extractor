import winreg

def convert_to_key(key):
    key_offset = 52
    chars = "BCDFGHJKMPQRTVWXY2346789"
    key_output = ""
    i = 28
    while i >= 0:
        cur = 0
        x = 14
        while x >= 0:
            cur = cur * 256
            cur = key[x + key_offset] + cur
            key[x + key_offset] = cur // 24
            cur = cur % 24
            x -= 1
        i -= 1
        key_output = chars[cur] + key_output
        if (29 - i) % 6 == 0 and i != -1:
            i -= 1
            key_output = "-" + key_output
    return key_output

key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion")
value, _ = winreg.QueryValueEx(key, "DigitalProductId")
print(convert_to_key(list(value)))
