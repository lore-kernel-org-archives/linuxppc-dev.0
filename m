Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <D73A25AA6E54D511AD74009027B1110F0F30B0@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: execute from flash?
Date: Mon, 25 Feb 2002 15:17:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone know how I can run a program in flash from my embedded linux
kernel that is also running in flash?  Below is the code that I tried but it
did not work.  It compiles but does not run correctly.

typedef int (codePtr(char *info));

void main(char *argv)
{
	int addr = 0xfff80000;
	codePtr* startloc = (codePtr *)addr;
	(startloc(argv));
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
