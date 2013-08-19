Return-Path: <tony.luck@gmail.com>
Received: from mail-ve0-x235.google.com (mail-ve0-x235.google.com
 [IPv6:2607:f8b0:400c:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A65112C014A
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Aug 2013 03:29:23 +1000 (EST)
Received: by mail-ve0-f181.google.com with SMTP id jz10so3144679veb.40
 for <linuxppc-dev@ozlabs.org>; Mon, 19 Aug 2013 10:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLFa+bC-atqy9X7yFJipB69qnPP_MqDRBgag10Q2Fas6A@mail.gmail.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <3908561D78D1C84285E8C5FCA982C28F31CBF152@ORSMSX106.amr.corp.intel.com>
 <CAGXu5jLFa+bC-atqy9X7yFJipB69qnPP_MqDRBgag10Q2Fas6A@mail.gmail.com>
Date: Mon, 19 Aug 2013 10:29:19 -0700
Message-ID: <CA+8MBbKThiU5JofYbHXNR9iUNmqn-A3K7PkAOpWATefCAwmQ0w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Add (de)compression support to pstore
From: Tony Luck <tony.luck@gmail.com>
To: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 17, 2013 at 11:32 AM, Kees Cook <keescook@chromium.org> wrote:
> Yeah, this is great. While I haven't tested it myself yet, the code
> seems to be in good shape. I acked the ram piece separately, but
> consider the entire series:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied.  This should show up in linux-next tomorrow.

Anyone using efivars as the pstore backend?  Testing reports (positive
or negative) appreciated.

-Tony
