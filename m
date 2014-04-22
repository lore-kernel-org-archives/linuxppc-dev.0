Return-Path: <anton@samba.org>
Date: Wed, 23 Apr 2014 08:02:24 +1000
From: Anton Blanchard <anton@samba.org>
To: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 10/33] powerpc: Ignore TOC relocations
Message-ID: <20140423080224.14c3530f@kryten>
In-Reply-To: <20140326093602.GM18201@bubble.grove.modra.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-11-git-send-email-anton@samba.org>
 <20140326093602.GM18201@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, rusty@rustcorp.com.au, ulrich.weigand@de.ibm.com,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alan,

> > The linker fixes up TOC. relocations, so prom_init_check.sh should
> > ignore them.
> 
> Err, .TOC. you mean.  Presumably something strips off the leading dot
> somewhere?

Yeah, the script strips them:

        # On 64-bit nm gives us the function descriptors, which have
        # a leading . on the name, so strip it off here.
        UNDEF="${UNDEF#.}"

I'll modify the commit message to be less confusing.

Anton
