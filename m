Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910806081827u776112c0x497c5ddf0f4667a@mail.gmail.com>
Date: Sun, 8 Jun 2008 21:27:47 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "linuxppc-dev list" <Linuxppc-dev@ozlabs.org>
Subject: zImage.chrp is getting gziped on Efika
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Z3ppcGluZyB0aGUgaW1hZ2UgdGFrZXMgdG8gbG9uZyBpbiBkZXZlbG9wbWVudCBjeWNsZSwgaG93
IGRvIEkgdHVybiBpdCBvZmY/CgpFZmlrYSBpcyBjaG9raW5nIG9uIGl0IHRvby4KCnpJbWFnZSBz
dGFydGluZzogbG9hZGVkIGF0IDB4MDA0MDAwMDAgKHNwOiAweDAxN2ZmOWUwKQpBbGxvY2F0aW5n
IDB4YzAyYTgzZGMgYnl0ZXMgZm9yIGtlcm5lbCAuLi4KT0YgdmVyc2lvbiA9ICdFRklLQTVLMiwx
LjMnCmd1bnppcHBpbmcgKDB4ZmZmZmZmZmYgPC0gMHgwMDQwNzAwMDoweDAwODM4Y2YxKS4uLixc
XVUKCu+/ve+/ve+/vdGl77+977+977+9amrvv700JSUC77+977+977+977+977+977+977+9KmUa
77+9JSUVAgLvv73vv73vv73vv73vv73vv73vv73vv73vv73vv70CajUlCQkT77+977+977+977+9
77+977+977+977+9atSk77+9ShUSJCRMXu+/vTA0MDExOUMKQ1RSICAgMHgwMDAwMDA3MCBDUiAg
IDB4NDAwMDIwMjQgICBYRVIgMHgwCkRBUiAgMHgwMDAwMDAwMCBEU0lTUiAweDAwMDAwMDAwIFR5
cGUgMgpHUFJbXSAweDAwMDAwMDA4IDB4MDE3RkY5NTAgMHgwMDAwMDAwMCAweDAwODM5MDE0IDB4
MDAwMDAwMDQKMHhDMDI5MjlFOCAweDAwODQzNTZDIDB4MDAwMDAwMDAKR1BSW10gMHgwMDAwMDAw
MCAweDAwMDAwMDAwIDB4MDAwMDAwNzAgMHgwMDAwMDA3MCAweDQwMDAyMDI0CjB4RkZGN0VGRkYg
MHhGN0Y3QkY3RiAweDZGRkFGRjZFCkdQUltdIDB4MDA0MzFDMzYgMHgwMDAwMDAwNCAweEMwMjky
OUU4IDB4MDAwMDAwMDAgMHgwMDAwMDAwMAoweEMwMjkyOTc3IDB4RjAwMDFGRkYgMHhGMDAwMDAy
QQpHUFJbXSAweDAwODM5MDE0IDB4MDA0MDcwQkIgMHgwMDQzMUMzNiAweDAwMDAwMDAwIDB4MDAw
MDAwMDYKMHgwMDgzOTA0NCAweDAwNDBFMUUwIDB4QzAyOTI5RTgKaWJhdDBVIDB4MDAwMDFGRkYg
aWJhdDBMIDB4MDAwMDAwMTIKaWJhdDFVIDB4RjAwMDFGRkYgaWJhdDFMIDB4RjAwMDAwMTIKCgot
LSAKSm9uIFNtaXJsCmpvbnNtaXJsQGdtYWlsLmNvbQo=
