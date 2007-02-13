Return-Path: <mikey@neuling.org>
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 12/16] Automatically lmb_reserve() initrd 
In-reply-to: <20070213061025.9BAEDDDD0E@ozlabs.org> 
References: <20070213061025.9BAEDDDD0E@ozlabs.org>
Date: Tue, 13 Feb 2007 18:14:19 +1100
Message-ID: <21494.1171350859@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> At present, when an initrd is passed to the kernel used flat device
> tree properties, the memory the initrd occupies must also be reserved
> in the flat tree's reserve map, or the kernel may overwrite it.  That
> makes life more complicated than it could be for the bootwrapper.
> 
> This patch makes the kernel automatically reserve the initrd's space.
> That in turn requires parsing the initrd parameters earlier than they
> are currently, in early_init_dt_scan_chosen() instead of
> check_for_initrd().

Cool... this should remove some code in kexec-tools as well.

Mikey
