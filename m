Return-Path: <anton@samba.org>
Date: Wed, 26 Mar 2014 22:20:50 +1100
From: Anton Blanchard <anton@samba.org>
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Subject: Re: [PATCH 00/33] Build ppc64le kernel using ABIv2
Message-ID: <20140326222050.30e68346@kryten>
In-Reply-To: <OF5605E77F.F2B0528E-ONC1257CA6.00487EE5-C1257CA6.00491690@de.ibm.com>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <OF5605E77F.F2B0528E-ONC1257CA6.00487EE5-C1257CA6.00491690@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mikey@neuling.org, amodra@gmail.com, rusty@rustcorp.com.au,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Uli,

> You probably should have two different macros _GLOBAL_TOC vs. _GLOBAL
> (or _GLOBAL vs. _GLOBAL_NOTOC), and use the variant that provides a
> global entry point setting up the TOC only with those functions that
> actually require a TOC.

I was worried that we might introduce subtle bugs by forgetting to use
the right version, but I agree it seems to be the only way.

> When I looked at this last time, I remarked:
> 
> >./platforms/pseries/hvCall.S:
> >./platforms/cell/beat_hvCall.S:
> >Looks safe since all functions are called via varargs prototypes
> >(or > 8 integer arguments).
> 
> Checking again, this still seems true.  These are the prototypes
> for all the functions in hvCall.S:

You are right, I forgot about your previous review. Thanks!

Anton
