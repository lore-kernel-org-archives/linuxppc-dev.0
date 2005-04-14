Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id BC74867A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 19:37:14 +1000 (EST)
To: "Fillod Stephane" <stephane.fillod@thomson.net>
Message-ID: <OFD3D0F6BD.3557C244-ONC1256FE3.0033B4B5@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 14 Apr 2005 11:38:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_RE=3A_mmap_=3A_please_help_!?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


St=E9phane,

thanks for your help.
But I think that, except instruction eieio,  I do similar things. You u=
se
the virtual address returned by mmap but have you the same values if yo=
u
use write/read(axs_mem_fd,...) instead of in_8/out_8.
That is  my problem : I want to be sure that when I use the virtual add=
ress
returned by mmap, I access really to the physical memory mapped area.

Do you know a shell command in order to dump the memory and verify what=
 I
do ?

----------------------------------------------------------
Sophie CARAYOL

TECHNOLOGIES & SYSTEMES
50 rue du Pr=E9sident Sadate
F - 29337 QUIMPER CEDEX

T=E9l: +33 2 98 10 30 06
mailto:scarayol@assystembrime.com
----------------------------------------------------------


=
