Return-Path: <michael@ellerman.id.au>
Date: Fri, 9 Aug 2013 13:21:06 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
Message-ID: <20130809032105.GA20970@concordia>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <520357D8.2090502@linux.vnet.ibm.com>
 <15944.1375958991@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15944.1375958991@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 08, 2013 at 08:49:51PM +1000, Michael Neuling wrote:
> > > +CONFIG_SCHED_SMT=y
> > > +CONFIG_PPC_DENORMALISATION=y
> > > +CONFIG_HOTPLUG_PCI=m
> > Why the value "m" in the le_config file, when it is "y" in
> > pseries_defconfig.
> 
> We are out of sync already!?!?! *sigh* ;-)

That's good, more coverage!

cheers
