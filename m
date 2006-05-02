Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 51F9967B9A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 09:49:19 +1000 (EST)
Date: Tue, 2 May 2006 16:49:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stephen Winiecki <stevewin@us.ibm.com>
Subject: Re: Configuring PCI w/ 44x
Message-ID: <20060502234916.GB25045@gate.ebshome.net>
References: <OF7EB5CFE4.CBC11341-ON87257162.0071F2FC-85257162.0072FFA5@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF7EB5CFE4.CBC11341-ON87257162.0071F2FC-85257162.0072FFA5@us.ibm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 02, 2006 at 04:58:32PM -0400, Stephen Winiecki wrote:
> I have a question regarding configuring PCI with 44x.  Using 2.6.17-rc3 as
> a reference, PCI_CONFIG is defined for the 44x defconfigs, and Kconfig is
> not enabled to reflect/change the setting for 44x.  When I update
> arch/ppc/Kconfig to enable configuring or not configuring PCI with 44x, and
> then don't configure it, the kernel won't compile:

Hmm, you cannot disable PCI for 44x in the current 2.6. It's always 
enabled.

If you changed Konfig to be able to do so, why are you complaining 
here? It's not enough to just change Konfig, you have to modify Ocotea 
port as well. Look for example how this is handled for 85xx.

Patches are welcome.

-- 
Eugene
