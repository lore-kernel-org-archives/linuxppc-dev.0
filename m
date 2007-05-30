Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 91B15DDE09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 May 2007 09:10:45 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m34so1238678wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 16:10:43 -0700 (PDT)
Message-ID: <fa686aa40705301610q6ba8f2abq482f43a89f44d1bc@mail.gmail.com>
Date: Wed, 30 May 2007 17:10:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: bert_maxel <bonlutin@hotmail.com>
Subject: Re: Audio Dirver for the 403/405?
In-Reply-To: <10883262.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <10883262.post@talk.nabble.com>
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

On 5/30/07, bert_maxel <bonlutin@hotmail.com> wrote:
>
> Hi all,
>
> Has anybody got some working audio driver (linux) for the  ML403/405 ?
> I know it's an ac97 codec, but I can't find anything related to the xilinx
> boards?
> If nobody has worked on this yet, I'm in trouble. I don't know where to
> start, or from what ac97 driver should I base my initial development?

IIRC, the old mvista 2.4 tree has an audio driver.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
