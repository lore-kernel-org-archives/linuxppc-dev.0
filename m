Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0602F@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: SELF: ramdisk which required libraries if ...?
Date: Sat, 11 Jan 2003 14:47:50 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am looking at SELF right now for a embedded PPC platform.

I am wondering what libraries are required if you compile with uclibc that
has shared libraries compiled out ...

Do I need some, none, or all?

To make my life easy here is a list of libraries ... which would I need ?

Regards,
Jim

lib/ld-2.1.2.so
lib/ld.so.1
lib/libc-2.1.2.so
lib/libc.so
lib/libc.so.6
lib/libcrypt-2.1.2.so
lib/libcrypt.so
lib/libcrypt.so.1
lib/libdl-2.1.2.so
lib/libdl.so
lib/libdl.so.2
lib/libnsl-2.1.2.so
lib/libnsl.so
lib/libnsl.so.1
lib/libnss_compat-2.1.2.so
lib/libnss_compat.so
lib/libnss_compat.so.2
lib/libnss_files-2.1.2.so
lib/libnss_files.so
lib/libnss_files.so.2
lib/libresolv-2.1.2.so
lib/libresolv.so
lib/libresolv.so.2
lib/libutil-2.1.2.so
lib/libutil.so
lib/libutil.so.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
