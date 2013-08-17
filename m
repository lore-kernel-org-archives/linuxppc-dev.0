Return-Path: <keescook@google.com>
Received: from mail-ie0-x22c.google.com (mail-ie0-x22c.google.com
 [IPv6:2607:f8b0:4001:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1D68E2C01BF
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Aug 2013 04:32:55 +1000 (EST)
Received: by mail-ie0-f172.google.com with SMTP id 17so5432822iea.3
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Aug 2013 11:32:52 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CBF152@ORSMSX106.amr.corp.intel.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <3908561D78D1C84285E8C5FCA982C28F31CBF152@ORSMSX106.amr.corp.intel.com>
Date: Sat, 17 Aug 2013 11:32:52 -0700
Message-ID: <CAGXu5jLFa+bC-atqy9X7yFJipB69qnPP_MqDRBgag10Q2Fas6A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] Add (de)compression support to pstore
From: Kees Cook <keescook@chromium.org>
To: "Luck, Tony" <tony.luck@intel.com>
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

On Fri, Aug 16, 2013 at 3:15 PM, Luck, Tony <tony.luck@intel.com> wrote:
>> Needs testing with erst backend, efivars and persistent ram.
>
> Tested against ERST - works fine for me now.
>
> Need to stare at the code to see if there are any more bits that could be cleaned up.
>
> Thanks for addressing my issues from v1

Yeah, this is great. While I haven't tested it myself yet, the code
seems to be in good shape. I acked the ram piece separately, but
consider the entire series:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
