Return-Path: <dceravigupta@gmail.com>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by ozlabs.org (Postfix) with ESMTP id 449B8B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 17:04:06 +1000 (EST)
Received: by pwi6 with SMTP id 6so406966pwi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 00:04:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <918.1280173321@redhat.com>
References: <AANLkTikJJYRP=5yPQ8dG9ofXz3HvWzfQU2kt4PDui7EF@mail.gmail.com>
	<918.1280173321@redhat.com>
Date: Tue, 27 Jul 2010 12:34:04 +0530
Message-ID: <AANLkTimLDLO5xr+sUPTB6GZph+T_-kf-ZHLox2b=PMHO@mail.gmail.com>
Subject: Re: Memory Mapping a char array in User Space
From: Ravi Gupta <dceravigupta@gmail.com>
To: David Howells <dhowells@redhat.com>
Content-Type: multipart/alternative; boundary=001636417bc14b47d1048c591bc1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636417bc14b47d1048c591bc1
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

Thanks for the quick reply. One more thing, in the end I have to memory map
a DMA buffer allocated using pci_alloc_consisten() function to user space.

*> I think you should be leaving the mapping to the core VM routines.*
*> Furthermore, I don't think *you* should be calling remap_pfn_range().*

Let say I have allocated a page using __get_free_pages(). But how would the
core VM routines knows that which page I want to memory map? If possible,
please explain with example.

--001636417bc14b47d1048c591bc1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi David,<br>
<br>
Thanks for the quick reply. One more thing, in the end I have to memory map=
 a=20
DMA buffer allocated using pci_alloc_consisten() function to user space.<br=
><br><i>&gt; I think you should be leaving the mapping to the core VM routi=
nes.</i><br>
<div class=3D"gmail_quote"><i>&gt; Furthermore, I don&#39;t think *you* sho=
uld be calling remap_pfn_range().</i><br></div><br>Let say I have allocated=
 a page using __get_free_pages(). But how would the core VM routines knows =
that which page I want to memory map? If possible, please explain with exam=
ple.<br>

--001636417bc14b47d1048c591bc1--
