Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 08/17] powerpc: Add FP/VSX and VMX register load functions
 for transactional memory
In-reply-to: <0233B491-CB0D-4B0C-9859-8B486D3C3314@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-9-git-send-email-mikey@neuling.org>
 <0233B491-CB0D-4B0C-9859-8B486D3C3314@kernel.crashing.org>
Date: Thu, 14 Feb 2013 12:53:19 +1100
Message-ID: <5963.1360806799@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +/* void do_load_up_fpu(struct thread_struct *thread)
> 
> Comment is wrong, should be void do_load_up_transact_fpu(...)

Ooops, thanks for the catch.

> > +/* void do_load_up_altivec(struct thread_struct *thread)
> 
> comment wrong.

Ooops again.

FYI I'm in Austin next week if you wanna grab a beer.

Mikey
