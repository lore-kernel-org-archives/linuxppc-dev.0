Return-Path: <stelios@stelioscellar.com>
From: "Stelios Koroneos" <stelios@stelioscellar.com>
To: "Iwan Koenig" <iwankoenig@yahoo.de>, <Linuxppc-embedded@ozlabs.org>
Subject: RE: Asterisk on Embedded Linux
Date: Wed, 27 Sep 2006 19:01:37 +0300
Message-ID: <HOECLKEKOHLAMMGDLLBHGEKJHLAA.stelios@stelioscellar.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20060926064451.71706.qmail@web26012.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> Does anyone known how to compile Asterisk for a
> powerpc-processor?

Asterisk + bristuff (for isdn support) for uclibc does crosscompile (and
run) but needs patching in several places (make files and asterisk itself).
We got the zaptel drivers to cross-compile also but it seems there are
endianess issues with the drivers we now try to iron out.

The main "difference" is that we have used OpenEmbedded as our build system
in order to get going.
