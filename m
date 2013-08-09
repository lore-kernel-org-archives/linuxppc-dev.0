Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] powerpc: put the common parts of the ppc64*defconfigs in a
 Kconfig file
In-reply-to: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
References: <20130809162426.ecdb5b034047db309ebd2b45@canb.auug.org.au>
Date: Fri, 09 Aug 2013 16:28:27 +1000
Message-ID: <28851.1376029707@ale.ozlabs.ibm.com>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> We cannot put the unsetting of config options in the Kconfig file, nor
> the integer or string options.
> 
> I checked that after this we get the same .config files generated (except
> for the addition of the new PPC64_DEFCONFIG* config options.
> 
> Any thoughts?

+1

Mikey
