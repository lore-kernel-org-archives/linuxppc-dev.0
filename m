Date: Tue, 2 Apr 2002 09:09:48 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200204021709.g32H9md07285@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Raw/unbuffered block device access
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to do 2 things:
1) Disable the linux buffer cache, so all block device/filesystem reads will
go directly to the block device and not use any cache.
2) Do raw access to the block device (specifically an ide hard drive) without
going through a filesystem, but I want to be able to queue up reads to reduce
seek times.

There don't exist docs on doing either thing, or postings, or any help on
the internet anywhere that I can find. Any advice welcome!!!!!!!

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
