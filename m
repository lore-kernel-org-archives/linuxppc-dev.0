Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: (X-Window) Yellowdog RPMs within ELDK?
Date: Mon, 12 May 2003 17:39:55 +0200
Message-ID: <30C145E544071F4FB8B627789F7910BD32BE04@csy-exchange1.giat.intra>
From: "ARIBAUD Albert" <A.ARIBAUD@giat-industries.fr>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I need to install X libraries and apps on
our custom 855T-based board running Linux.
Since ELDK derives from Yellowdog, I thought
I'd use RPMs from Yellowdog.

Trouble is, if I 'ppc-rpm' an YDL package,
I get an architecture mismatch (which is
not surprising, all ELDK packages being
'ppc_8xx' while YDL packages are 'ppc').

I've tried a sneaky --ignorearch, which
led ppc-rpm to seemingly accept the
previously offending package. But then,
if I 'ppc-rpm -qa', the package isn't
listed.

Anybody help! :)

Thanks in advance,

Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
