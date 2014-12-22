Return-Path: <geoff@infradead.org>
Message-ID: <1419269161.3786.4.camel@infradead.org>
Subject: Re: [PATCH] arch: powerpc: platforms: ps3: repository.c:  Remove
 unused function
From: Geoff Levand <geoff@infradead.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Andre
 Heider <a.heider@gmail.com>, Nathan Whitehorn <nwhitehorn@freebsd.org>
Date: Mon, 22 Dec 2014 09:26:01 -0800
In-Reply-To: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-12-20 at 16:00 +0100, Rickard Strandqvist wrote:
> Remove the function ps3_repository_write_highmem_info() that is not used anywhere.

NAK

ps3_repository_write_highmem_info() is needed by otheros++.  What we
need is a kernel patch to add the highmem info to the repository once it
is known.

These ps3_repository_write_highmem routines are also the only
documentation the freeBSD port has as to how the highmem info is (should
be) saved in the repository.

-Geoff
