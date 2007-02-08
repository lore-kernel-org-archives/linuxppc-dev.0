Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 2F930DDE02
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:51:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Celleb: improve htab lock
Date: Thu, 8 Feb 2007 07:51:44 +0100
References: <200702080618.l186InGM014774@toshiba.co.jp>
In-Reply-To: <200702080618.l186InGM014774@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702080751.45278.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1cnNkYXkgMDggRmVicnVhcnkgMjAwNyAwNzoxOCwgSXNoaXpha2kgS291IHdyb3RlOgo+
IHMpOwo+ICugoKCgoKCgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwo+ICugoKCgoKCgc3Bpbl9sb2Nr
KCZiZWF0X2h0YWJfbG9jayk7Cj4goKCgoKCgoKBkdW1teTEgPSBiZWF0X2xwYXJfaHB0ZV9nZXR3
b3JkMChzbG90KTsKPiCgCj4goKCgoKCgoKBpZiAoKGR1bW15MSAmIH4weDdGVUwpICE9ICh3YW50
X3YgJiB+MHg3RlVMKSkgewo+IKCgoKCgoKCgoKCgoKCgoKBEQkdfTE9XKCJub3QgZm91bmQgIVxu
Iik7Cj4gLaCgoKCgoKCgoKCgoKCgoHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmJlYXRfaHRhYl9s
b2NrLCBmbGFncyk7Cj4gK6CgoKCgoKCgoKCgoKCgoHNwaW5fdW5sb2NrKCZiZWF0X2h0YWJfbG9j
ayk7Cj4gK6CgoKCgoKCgoKCgoKCgoGxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsKPiCgoKCgoKCg
oKCgoKCgoKCgcmV0dXJuOwo+IKCgoKCgoKCgfQo+IKAKPiCgoKCgoKCgoGxwYXJfcmMgPSBiZWF0
X3dyaXRlX2h0YWJfZW50cnkoMCwgc2xvdCwgMCwgMCwgSFBURV9WX1ZBTElELCAwLAo+IKCgoKCg
oKCgoKCgoKCgoKAmZHVtbXkxLCAmZHVtbXkyKTsKPiAtoKCgoKCgoHNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmJlYXRfaHRhYl9sb2NrLCBmbGFncyk7Cj4gK6CgoKCgoKBzcGluX3VubG9jaygmYmVh
dF9odGFiX2xvY2spOwo+ICugoKCgoKCgbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwoKVGhlIGZ1
bmN0aW9uIG5vcm1hbGx5IHVzZWQgaGVyZSB3b3VsZCBiZSBzcGluX2xvY2tfaXJxKCkvc3Bpbl91
bmxvY2tfaXJxKCksCndoaWNoIGRvZXMgc3Bpbl97LHVufWxvY2sgYWxvbmcgd2l0aCBsb2NhbF9p
cnFfe3NhdmUscmVzdG9yZX0uCgoJQXJuZCA8PjwK
