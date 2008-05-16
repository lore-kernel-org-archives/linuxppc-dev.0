Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 447F5DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 01:53:58 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so279553anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 08:53:57 -0700 (PDT)
Message-ID: <fa686aa40805160853ube181b8k2ef79fcc783613d4@mail.gmail.com>
Date: Fri, 16 May 2008 09:53:57 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
Subject: Re: Suitability of patchs as attachments
In-Reply-To: <1CADFA951940554D86FBD8B24BBFF3A00129CBF5@LONMLVEM08.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1CADFA951940554D86FBD8B24BBFF3A00129CBF5@LONMLVEM08.e2k.ad.ge.com>
Cc: "Lissaman, Stuart \(GE EntSol,
	Intelligent Platforms\)" <stuart.lissaman@gefanuc.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, May 16, 2008 at 2:46 AM, Welch, Martyn (GE EntSol, Intelligent
Platforms) <martyn.welch@gefanuc.com> wrote:
> Hi all,
>
> I wish I didn't have to ask this but...
>
> For now I'm stuck using Outlook and Exchange for email, despite my best
> efforts I have been unable to force it to send patchs inline without
> breaking them (I can get it to do plain text, however it seems to have
> the habbit of wrapping ling lines, such as the "diff --git..." lines).
>
> Is anyone in the same position and has worked out how to do this?

Yes, don't use your email client for actually sending the patches.
Use git-send-email for 'stg mail' to send your patches from the
command line.  Your Exchange server should have SMTP turned on and you
can send directly to it.  Otherwise, you can try connecting to an
external open SMTP relay.

You'll still receive the replies and comments in Outlook.

Cheers,
g.

>
> I also have a patch for initial support of one of our boards waiting
> here, would it be acceptable to attach this as a patch on this mailing
> list?
>
> Thanks,
>
> Martyn
>
> ----
> Martyn Welch MEng MPhil MIET
> Principal Software Engineer
>
> GE Fanuc Intelligent Platforms
> Tove Valley Business Park, Towcester,
> Northants, NN12 6PF, United Kingdom
>
> Telephone: +44 (0) 1327 359444
> Direct Dial: +44 (0) 1327 322748
> Fax: +44 (0) 1327 322800
> email: martyn.welch@gefanuc.com
> web: www.gefanuc.com
>
> GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
> (3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
> 476
>
> GE Fanuc Intelligent Platforms Confidential and Proprietary. If you have
> received this message in error please notify us immediately and
> permanently remove it from your system and destroy any printed
> hardcopies.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
