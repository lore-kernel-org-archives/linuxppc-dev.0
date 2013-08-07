Return-Path: <michael@ellerman.id.au>
Date: Wed, 7 Aug 2013 15:16:18 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
Message-ID: <20130807051618.GB19998@concordia>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <2419.1375831860@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2419.1375831860@ale.ozlabs.ibm.com>
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

On Wed, Aug 07, 2013 at 09:31:00AM +1000, Michael Neuling wrote:
> Anton Blanchard <anton@samba.org> wrote:
> 
> > This is the pseries_defconfig with CONFIG_CPU_LITTLE_ENDIAN enabled
> > and CONFIG_VIRTUALIZATION disabled (required until we fix some
> > endian issues in KVM).
> 
> The CONFIG_VIRTUALIZATION disabling should be done in the Kconfig not
> here. 
> 
> I'm not that keen on another defconfig.  benh is already talking about
> having a powernv defconfig.  I'm worried we are going to fragment the
> defconfigs.  If you want something special like LE, then change the
> default one.  

I disagree. defconfigs are great because they're easy to add to kisskb
or other auto builders, making automated build testing easier.

In fact because the defconfigs are pretty much the only thing that
people build test, if you stray too far from them you are almost
guaranteed to find breakage. For example the UP build was broken for
months because we didn't have a defconfig for it.

cheers
