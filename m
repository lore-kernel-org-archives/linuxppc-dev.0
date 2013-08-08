Return-Path: <anton@samba.org>
Date: Thu, 8 Aug 2013 17:53:24 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
Message-ID: <20130808175324.735c1575@kryten>
In-Reply-To: <2419.1375831860@ale.ozlabs.ibm.com>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <2419.1375831860@ale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> The CONFIG_VIRTUALIZATION disabling should be done in the Kconfig not
> here. 
> 
> I'm not that keen on another defconfig.  benh is already talking about
> having a powernv defconfig.  I'm worried we are going to fragment the
> defconfigs.  If you want something special like LE, then change the
> default one.

I agree we don't want machine specific defconfigs, but I think it makes
sense to have ones that cover the key options that conflict. I'm
thinking 32bit, 64bit, 64bit BookE, 64bit LE etc.

One bonus is if we have a smaller set of defconfigs we might actually
get better testing. I have no idea which 32bit defconfigs I should test
for example, and I'm not going to test them all!

Anton
