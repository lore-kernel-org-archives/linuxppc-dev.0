Return-Path: <sachinpc@gmail.com>
Message-ID: <66164fbc0501190353265167b0@mail.gmail.com>
Date: Wed, 19 Jan 2005 17:23:42 +0530
From: Sachin P <sachinpc@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: consistent_alloc() on PPC
Reply-To: Sachin P <sachinpc@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi , 
I am facing some problems porting my drivers to the PPC platform . Am
currently using consistent_alloc() and consistent_free() to
allocate/free (non-cached) DMA ble memory.
Is there any function/patch/macro, equivalent to
phy_to_virt()/virt_to_phy() for memory returned by consistent_alloc()?

Regards
sachin
