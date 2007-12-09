Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id AADEDDDDD6
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 17:22:04 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so279777anc
	for <linuxppc-dev@ozlabs.org>; Sat, 08 Dec 2007 22:22:03 -0800 (PST)
Message-ID: <fa686aa40712082222o2001bc23y377d82e213b111a0@mail.gmail.com>
Date: Sat, 8 Dec 2007 23:22:03 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jerry Van Baren" <gvb.linuxppc.dev@gmail.com>
Subject: Re: Stupid git question: adding acked-by
In-Reply-To: <475B7B41.4000505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <475B7B41.4000505@gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/8/07, Jerry Van Baren <gvb.linuxppc.dev@gmail.com> wrote:
> Stacked git should work (effectively does the same thing but more
> gracefully), but I have not gone that route yet.

This is my preferred solution, but you don't have to do it this way.

>
> There must be a better way, if only I could find the right (of 137)
> git-* command...

Try git-cherry-pick.  Get a list of the SHA-1 patch ids and reset your
branch.  Then cherry pick each patch with the -e flag.  Git will pull
up an editor and let you edit the commit message before applying so
you can add the Acked-by line.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
