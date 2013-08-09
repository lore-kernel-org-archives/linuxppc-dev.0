Return-Path: <michael@ellerman.id.au>
Date: Fri, 9 Aug 2013 13:23:53 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
Message-ID: <20130809032353.GB20970@concordia>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <2419.1375831860@ale.ozlabs.ibm.com>
 <20130808175324.735c1575@kryten>
 <25736.1376003557@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25736.1376003557@ale.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 09, 2013 at 09:12:37AM +1000, Michael Neuling wrote:
> Anton Blanchard <anton@samba.org> wrote:
> 
> > 
> > Hi,
> > 
> > > The CONFIG_VIRTUALIZATION disabling should be done in the Kconfig not
> > > here. 
> > > 
> > > I'm not that keen on another defconfig.  benh is already talking about
> > > having a powernv defconfig.  I'm worried we are going to fragment the
> > > defconfigs.  If you want something special like LE, then change the
> > > default one.
> > 
> > I agree we don't want machine specific defconfigs, but I think it makes
> > sense to have ones that cover the key options that conflict. I'm
> > thinking 32bit, 64bit, 64bit BookE, 64bit LE etc.
> > 
> > One bonus is if we have a smaller set of defconfigs we might actually
> > get better testing. I have no idea which 32bit defconfigs I should test
> > for example, and I'm not going to test them all!
> 
> FWIW, I test with these configs and it seems to catch most of 32/64 bit,
> SMP/UP, differnt MMU issues:
> 
>   pseries_defconfig 
>   ppc64_defconfig 
>   ppc64e_defconfig 
>   pmac32_defconfig
>   ppc44x_defconfig 
>   ppc6xx_defconfig 
>   mpc85xx_smp_defconfig
>   mpc85xx_defconfig 
>   chroma_defconfig 

>   ps3_defconfig 
>   celleb_defconfig

I think cell_defconfig pretty much covers these too, and also gets you
coverage of the IBM blades.

And add randconfig too :)

cheers
