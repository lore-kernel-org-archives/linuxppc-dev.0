Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18367.34338.962846.402664@cargo.ozlabs.ibm.com>
Date: Sat, 23 Feb 2008 13:34:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 5/5] [POWERPC] Add 460EX PCIe support to 4xx pci driver
In-Reply-To: <1203602482-11415-1-git-send-email-sr@denx.de>
References: <1203602482-11415-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese writes:

> Tested on AMCC Canyonlands eval board.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

With 173 lines of code added, you could spend a paragraph in the patch
description telling us why the patch is doing what it's doing the way
it's doing it.  Perhaps even tell us why it takes 173 new lines of
code to do something that sounds pretty simple - tell us what the
complexities you encountered were.

Paul.
