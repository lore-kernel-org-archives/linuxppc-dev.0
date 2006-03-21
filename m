Return-Path: <hans@fugal.net>
Received: from mgr3.xmission.com (mgr3.xmission.com [198.60.22.203])
	by ozlabs.org (Postfix) with ESMTP id AF8C067A39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 07:17:17 +1100 (EST)
Received: from mgr1.xmission.com ([198.60.22.201])
	by mgr3.xmission.com with esmtp (Exim 4.50) id 1FLhXS-0006ay-BP
	for linuxppc-dev@ozlabs.org; Tue, 21 Mar 2006 07:08:46 -0700
Received: from [205.208.239.165] (helo=[192.168.0.4])
	by mgr1.xmission.com with esmtpa (Exim 4.50) id 1FLhXR-0007Hn-4i
	for linuxppc-dev@ozlabs.org; Tue, 21 Mar 2006 07:08:46 -0700
Message-ID: <442008EE.6040808@fugal.net>
Date: Tue, 21 Mar 2006 07:08:46 -0700
From: Hans Fugal <hans@fugal.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------060509050506060105070306"
Subject: [Fwd: Re: make install on ppc]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060509050506060105070306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is there something that stops us from having a make install target for ppc?

--------------060509050506060105070306
Content-Type: message/rfc822;
 name="Re: make install on ppc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: make install on ppc"

Return-Path: <sam@ravnborg.org>
X-Original-To: fugalh@falcon.fugal.net
Delivered-To: fugalh@falcon.fugal.net
Received: from localhost (falcon.fugal.net [127.0.0.1])
	by falcon.fugal.net (Postfix) with ESMTP id C133F1CC08
	for <fugalh@falcon.fugal.net>; Mon, 20 Mar 2006 23:30:11 -0700 (MST)
Received: from falcon.fugal.net ([127.0.0.1])
	by localhost (falcon.fugal.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07554-10 for <fugalh@falcon.fugal.net>;
	Mon, 20 Mar 2006 23:30:11 -0700 (MST)
Received: from pasmtp.tele.dk (pasmtp.tele.dk [193.162.159.95])
	by falcon.fugal.net (Postfix) with ESMTP id 3E66E1C637
	for <hans@fugal.net>; Mon, 20 Mar 2006 23:30:10 -0700 (MST)
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id B1E321EC301;
	Tue, 21 Mar 2006 07:29:58 +0100 (CET)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 2EFA043C085; Tue, 21 Mar 2006 07:29:43 +0100 (CET)
Date: Tue, 21 Mar 2006 07:29:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Hans Fugal <hans@fugal.net>
Cc: kai@germaschewski.name
Subject: Re: make install on ppc
Message-ID: <20060321062943.GA3677@mars.ravnborg.org>
References: <20060319001919.GA32129@falcon.fugal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060319001919.GA32129@falcon.fugal.net>
User-Agent: Mutt/1.5.11
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.155804, version=1.0.1

On Sat, Mar 18, 2006 at 05:19:19PM -0700, Hans Fugal wrote:
> I apologize if you are not the right people to send this to. On i386
> there is a make install target, but on ppc there is not. The
> distribution is Debian in both cases, and the sources are plain vanilla.
> 
> Is this an oversight?
This is up to the arch maintainers to add as required.
Please ask the at relevant ppc mailing list.

	Sam


--------------060509050506060105070306--
