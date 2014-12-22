Return-Path: <nwhitehorn@freebsd.org>
Message-ID: <54985686.7080609@freebsd.org>
Date: Mon, 22 Dec 2014 09:36:06 -0800
From: Nathan Whitehorn <nwhitehorn@freebsd.org>
MIME-Version: 1.0
To: Geoff Levand <geoff@infradead.org>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH] arch: powerpc: platforms: ps3: repository.c:  Remove
 unused function
References: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1419269161.3786.4.camel@infradead.org>
In-Reply-To: <1419269161.3786.4.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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


On 12/22/14 09:26, Geoff Levand wrote:
> On Sat, 2014-12-20 at 16:00 +0100, Rickard Strandqvist wrote:
>> Remove the function ps3_repository_write_highmem_info() that is not used anywhere.
> NAK
>
> ps3_repository_write_highmem_info() is needed by otheros++.  What we
> need is a kernel patch to add the highmem info to the repository once it
> is known.
>
> These ps3_repository_write_highmem routines are also the only
> documentation the freeBSD port has as to how the highmem info is (should
> be) saved in the repository.
>
> -Geoff
>
>

Yes, we really need this for FreeBSD since that port uses the repository 
directly instead of FDT. Thanks for noticing this. We could adapt 
FreeBSD to use FDT (this is the only non-device-tree PowerPC port), but 
there hasn't been any reason to do that thus far given the availability 
of the repository information.
-Nathan
