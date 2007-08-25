Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by ozlabs.org (Postfix) with ESMTP id 7B521DDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Aug 2007 01:24:33 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so708673nzf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 08:24:32 -0700 (PDT)
Message-ID: <fa686aa40708250824v486d2228g29250aad6b517c42@mail.gmail.com>
Date: Sat, 25 Aug 2007 09:24:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: how to get your linux-2.6-virtex tree?
In-Reply-To: <BAY138-F32C3A2797C436D673EABDDB2D00@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40708250710q72bdaa90na4974f1af6030997@mail.gmail.com>
	<BAY138-F32C3A2797C436D673EABDDB2D00@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/25/07, Ming Liu <eemingliu@hotmail.com> wrote:
> Dear Grant,
>
> >What does 'dig git.secretlab.ca' tell you?  I see this:
> >;; ANSWER SECTION:
> >git.secretlab.ca.       1320    IN      A       208.123.74.12
>
> I released 'dig git.secretlab.ca' and saw this:
> ;; QUESTION SECTION:
> ;git.secretlab.ca.              IN      A
>
> ;; ANSWER SECTION:
> git.secretlab.ca.       855     IN      A       208.123.74.12

Upgrade to a newer version of git.  git.secretlab.ca uses the virtual
hosting feature of git daemon, but you need to be using git version >
1.5

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
