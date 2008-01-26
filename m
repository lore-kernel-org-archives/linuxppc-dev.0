Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 8FA8CDDE18
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 14:17:12 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so242962anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 19:17:10 -0800 (PST)
Message-ID: <fa686aa40801251917t35d23604j1a5f68daca9227eb@mail.gmail.com>
Date: Fri, 25 Jan 2008 20:17:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Gortmaker" <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] 5200 dts: add default address and size cells to soc node.
In-Reply-To: <1201293200-32031-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1201293200-32031-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/25/08, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> The various 5200 dts files don't have values specified for the soc
> node, which in turn results in a warning from the processing of
> every child node (roughly 40 warnings per file).  This explicitly
> sets the default values and gets rid of all the warnings.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied, thanks!

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
