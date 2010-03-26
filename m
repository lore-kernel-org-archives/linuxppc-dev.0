Return-Path: <dwilson@fulcrummicro.com>
Message-ID: <4BAC0D4B.3030507@fulcrummicro.com>
Date: Thu, 25 Mar 2010 18:26:35 -0700
From: Dan Wilson <dwilson@fulcrummicro.com>
MIME-Version: 1.0
To: Linuxppc-dev@lists.ozlabs.org
Subject: Resetting PCI-E devices after linux boot
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are building a PCI-E device for use in an embedded system with an 
85xx processor.  One of our customers is adamant that linux PCI-E 
hot-swap support will not allow us to either bring the device up after 
linux boot (i.e., the PCI-E device must be present when linux scans for 
PCI-E devices at startup) or to reset the device once linux is up.  It 
was our impression that the PCI-E hot-swap support should allow for 
devices to appear after linux boot, be properly initialized, and then 
later be able to shut them down and bring them back up again.

Has anyone successfully used the PCI-E hot-swap capabilities in the 
linux kernel in a PPC 85xx environment?  Any known gotchas we need to be 
aware of?

Thanks in advance for your responses,

Dan.
