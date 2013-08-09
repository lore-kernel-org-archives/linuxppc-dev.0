Return-Path: <anton@samba.org>
Date: Fri, 9 Aug 2013 16:08:08 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 36/63] powerpc: Book 3S MMU little endian support
Message-ID: <20130809160808.64aaee36@kryten>
In-Reply-To: <20130807042049.GC31007@iris.ozlabs.ibm.com>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-37-git-send-email-anton@samba.org>
 <20130807042049.GC31007@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Paul,

> On Wed, Aug 07, 2013 at 02:01:53AM +1000, Anton Blanchard wrote:
> 
> > +#ifdef __BIG_ENDIAN__
> >  #define HPTE_LOCK_BIT 3
> > +#else
> > +#define HPTE_LOCK_BIT (63-3)
> > +#endif
> 
> Are you deliberately using a different bit here?  AFAICS you are using
> 0x20 in the 7th byte as the lock bit for LE, whereas we use 0x08 in
> that byte on BE.  Both are software-use bits, so it will still work,
> but is there a rationale for the change?  Or did you mean (56+3)
> rather than (63-3)?

Ouch, nice catch! I got lucky there.

Anton
