Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-06.bluehost.com (outbound-mail-06.bluehost.com
	[67.138.240.206]) by ozlabs.org (Postfix) with SMTP id 7D7B868914
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 03:27:19 +1100 (EST)
Message-ID: <43B95448.3040407@secretlab.ca>
Date: Mon, 02 Jan 2006 09:26:48 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>
References: <11359385991901-git-send-email-grant.likely@secretlab.ca>	<43B5E37A.4020008@dlasys.net>
	<43B601CC.1000102@secretlab.ca> <43B6B32A.5060606@dlasys.net>
In-Reply-To: <43B6B32A.5060606@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 8/8] Add support for Xilinx ML403 reference design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David H. Lynch Jr. wrote:
> Grant Likely wrote:
> 
>>David H. Lynch Jr. wrote:
> 
> 
>>Since the E-12 is a commercially available board, it would be useful to
>>have the patches on the ML, even if they don't get applied to mainline.
> 
> 
> 	So at what state should things be at before posting them ?
> 
> 	Right now:
> 		The basic E-12 stuff is complete - though it couls use some polish. It
> was based on the ML300 code, and almost certainly overlaps and conflicts
> with your ML403 work. I would be happy to reconcile them, but I would
> need to know what to work against.
If you want initial comments, then don't worry about polish; Send your
raw diff (in unified format please!) and put [RFC] in the subject line
so nobody mistakes it as stable code.  :)  I'll happily comment on it.

I'm sure it conflicts with my ML403 work considering I've moved from the
OCP to the platform bus.

> 
> 		I am not a git expert at this point. 
Neither am I.  :)

Try this:
install GIT:     http://linux.yyz.us/git-howto.html#installing_git
install Cogito:  http://www.kernel.org/pub/software/scm/cogito/README
easy user guide: http://wellington.pm.org/archive/200510/git/

> I am working against the 2.6.14.5
> source3 on kernel.org. There are numerous git trees what is the right one ?
I'm using Linus's tree, seeked to tag v2.6.14.

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

> 
> 	
> 		The serial/console drivers for the "Keyhole" - a bidirectional link
> between a Linux/Windows development host and the E-12, and the Xilinx
> UartLite are in (hopefully) late debugging, Output is probably complete,
> UartLite input needs testing, Keyhole input needs alot of work - among
> other things the host side is still only a display, so it is somewhat
> difficult to do the Linux input side.
> 


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
