Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94AFC1A02C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 04:45:08 +1100 (EST)
Message-ID: <5432D4E7.3060804@zytor.com>
Date: Mon, 06 Oct 2014 10:44:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
References: <cover.1408731991.git.geoff@infradead.org>	
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>	
 <20140825172234.GD14379@redhat.com> <1409402838.21896.99.camel@x220>
In-Reply-To: <1409402838.21896.99.camel@x220>
Content-Type: text/plain; charset=utf-8
Cc: maximilian attems <max@stro.at>, Geoff Levand <geoff@infradead.org>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2014 05:47 AM, Paul Bolle wrote:
> 
> Obviously, this can only break compiling those libraries, or other
> users. It can't break already compiled binaries. Besides I don't think
> those libraries, etc actually exist. Maximilian mentioned klibc in
> January, but I wasn't able to find a version of klibc that cared about
> this prototype. No one pointed me at a version that does (or any other
> library, etc., for that matter).
> 

... and that would be a klibc bug and we'd just fix it.

	-hpa
