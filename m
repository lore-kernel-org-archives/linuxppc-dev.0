Message-ID: <E1836A7F3557D311A14000805F9F36FC0141C7B7@usdfo011.usac.danfoss.net>
From: Hihn Jason <JasonHihn@DANFOSS.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: changes to /proc files
Date: Wed, 24 Jul 2002 19:34:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm writing a little GPL app that needs to monitor some data in /proc. I
seem to recall (possibly incorrectly) that there was some magic way for a
program to be notified when a file in /proc changes, rather than having to
poll. I can't seem to find anything in Google.

Can anyone point me in the right direction?
What is the overhead in polling and reading a small (~500b) /proc file?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
