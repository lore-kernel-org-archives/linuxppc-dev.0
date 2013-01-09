Return-Path: <walken@google.com>
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com
 [209.85.212.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5113C2C073E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 12:32:09 +1100 (EST)
Received: by mail-vb0-f48.google.com with SMTP id fc21so1073935vbb.35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2013 17:32:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1357694895-520-1-git-send-email-walken@google.com>
References: <1357694895-520-1-git-send-email-walken@google.com>
Date: Tue, 8 Jan 2013 17:32:05 -0800
Message-ID: <CANN689EMBPqVCZdTZm1G0PznGpYR6Y5tMUOspE+emHaX=TkVtA@mail.gmail.com>
Subject: Re: [PATCH 0/8] vm_unmapped_area: finish the mission
From: Michel Lespinasse <walken@google.com>
To: Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Matt Turner <mattst88@gmail.com>,
 David Howells <dhowells@redhat.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Whoops, I was supposed to find a more appropriate subject line before
sending this :]

On Tue, Jan 8, 2013 at 5:28 PM, Michel Lespinasse <walken@google.com> wrote:
> These patches, which apply on top of v3.8-rc kernels, are to complete the
> VMA gap finding code I introduced (following Rik's initial proposal) in
> v3.8-rc1.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
