Return-Path: <jalmeida@sysgo.fr>
Message-ID: <46CE8FD5.2060609@sysgo.fr>
Date: Fri, 24 Aug 2007 09:59:17 +0200
From: Jose Almeida <jalmeida@sysgo.fr>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: little endian page mapping on PQ3
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Looking at PQ3 documentation, it looks like there is a way to select
on a page basis if we would like to map one particular page in BIG or
LITTLE endian.
This is a very nice feature when you need to exchange some data
between a PC and a PQ3 target.

I am wondering if someone have already tryed this PQ3 feature ?
I guess this would require some kind of hook in the kernel ...

Any clue ?

Thanks -  Jose
