Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18666.64828.195065.641344@cargo.ozlabs.ibm.com>
Date: Tue, 7 Oct 2008 17:10:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.27-rc8 boot failure
In-Reply-To: <1223055651.3419.47.camel@badari-desktop>
References: <1223055651.3419.47.camel@badari-desktop>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty writes:

> I am not able to boot my Power5 box with 2.6.27-rc8 (defconfig).
> However, I am able to boot with my own custom config.
> 
> Known issue ?

No, and I wasn't able to replicate it on a power5 partition here...

Could you look up what is at 0xc00000000097a02c in your vmlinux (not
zImage)?

Paul.
