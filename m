Return-Path: <geoff@infradead.org>
Message-ID: <1419302677.4364.100.camel@smoke>
Subject: Re: [PATCH] arch: powerpc: platforms: ps3: repository.c:  Remove
 unused function
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 22 Dec 2014 18:44:37 -0800
In-Reply-To: <1419294380.30550.1.camel@ellerman.id.au>
References: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1419269161.3786.4.camel@infradead.org>
 <1419294380.30550.1.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Andre Heider <a.heider@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Nathan Whitehorn <nwhitehorn@freebsd.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Tue, 2014-12-23 at 11:26 +1100, Michael Ellerman wrote:
> On Mon, 2014-12-22 at 09:26 -0800, Geoff Levand wrote:
> > ps3_repository_write_highmem_info() is needed by otheros++.  What we
> > need is a kernel patch to add the highmem info to the repository once it
> > is known.
> 
> OK so where's that patch?

I put one in my ps3-linux repo.  I'll post it after I do some more
testing.

-Geoff
