Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Message-ID: <0B0A39652BB0D411BCCF00508B9512EC0E5962B3@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: How to pass "-Wa,e500" to gcc when building a bootstrap compiler
	?
Date: Wed, 28 Jan 2004 19:44:02 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

I am trying to build a cross-compiler tool chain for mpc8540 - powerquicc3.
But I wish to build option '-Wa,e500' into bootstrap gcc so that I do not
worry
it later when rebuilding glibc etc.

Is there any trick to make gcc have a default option like '-Wa,e500' ?

Thanks.

Bo Yu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
