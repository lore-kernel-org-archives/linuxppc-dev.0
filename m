Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
In-reply-to: <520357D8.2090502@linux.vnet.ibm.com>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <520357D8.2090502@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 20:49:51 +1000
Message-ID: <15944.1375958991@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +CONFIG_SCHED_SMT=y
> > +CONFIG_PPC_DENORMALISATION=y
> > +CONFIG_HOTPLUG_PCI=m
> Why the value "m" in the le_config file, when it is "y" in
> pseries_defconfig.

We are out of sync already!?!?! *sigh* ;-)

> Also I do see a warning saying invalid value for this symbol.

Mikey
