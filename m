Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 29062DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 15:42:10 +1000 (EST)
Date: Tue, 29 Apr 2008 01:42:08 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [RESEND][PATCH 1/2][POWERPC] PIKA Warp: Update platform code
	tosupportRev B boards
Message-ID: <20080429014208.79755860@lappy.seanm.ca>
In-Reply-To: <18454.44365.719572.654726@cargo.ozlabs.ibm.com>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080428214711.240419c3@lappy.seanm.ca>
	<20080428232855.22c13830@lappy.seanm.ca>
	<18454.44365.719572.654726@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 29 Apr 2008 15:08:29 +1000
"Paul Mackerras" <paulus@samba.org> wrote:

> It doesn't help that both of these patches have the same subject line,
> nor that it starts with "Re:". :(

Sorry about that. I just split up the two patches, but the same subject
does apply to both. The code currently in the mainline kernel is for a
Rev A. Since there are no Rev As outside of PIKA, that is not very
useful. These patches bring the platform code up to Rev B standards
(while still maintaining Rev A support).

So the subject is correct for both.

> Also, I find the statement "A change to the dts to get gpios correct
> broke the led code" a bit opaque.  It doesn't tell me in what way it
> was broken or what this patch does to correct, or even what the change
> was in enough detail that I could find the change in the git
> repository.

You won't find it. One of the problems is that I am basically adding
patches to patches to patches, but since none of them are in a
mainline git, they all just keep showing up as one big patch. 

That comment was meant as a quick note to explain why the platform patch
changed from the previous platform patch. Short of diffing the
patches, you can't easily see how they changed.

After the Warp is released (sometime in May), the hardware churn should
end and I can submit patches one at a time rather than one massive
patch.

Cheers,
   Sean
