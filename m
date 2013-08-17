Return-Path: <keescook@google.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8013B2C021E
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Aug 2013 04:26:35 +1000 (EST)
Received: by mail-ie0-f175.google.com with SMTP id s9so5321761iec.34
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Aug 2013 11:26:31 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20130816131907.3338.76154.stgit@aruna-ThinkPad-T420>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131907.3338.76154.stgit@aruna-ThinkPad-T420>
Date: Sat, 17 Aug 2013 11:26:30 -0700
Message-ID: <CAGXu5jLzE3duC3vB8PTpvYroWmJDSU9ZSR3AKopKgRAwGZx4Fw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/11] pstore/ram: Read and write to the
 'compressed' flag of pstore
From: Kees Cook <keescook@chromium.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jkenisto@linux.vnet.ibm.com, Tony Luck <tony.luck@intel.com>,
 Colin Cross <ccross@android.com>, LKML <linux-kernel@vger.kernel.org>,
 mahesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 16, 2013 at 6:19 AM, Aruna Balakrishnaiah
<aruna@linux.vnet.ibm.com> wrote:
> In pstore write, add character 'C'(compressed) or 'D'(decompressed)
> in the header while writing to Ram persistent buffer. In pstore read,
> read the header and update the 'compressed' flag accordingly.
>
> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>

Nice work!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
Chrome OS Security
