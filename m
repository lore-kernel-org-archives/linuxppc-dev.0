Message-ID: <3F5FEFA0.1080809@embeddededge.com>
Date: Wed, 10 Sep 2003 23:44:32 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Curtis, Allen (by way of Allen Curtis <acurtis@onz.com>)" <Allen.Curtis@Thales-IFS.com>
Cc: PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8266ADS patch
References: <5.2.1.1.2.20030910174452.02767580@192.168.1.10>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Curtis, Allen (by way of Allen Curtis ) wrote:

 > Here is a patch to make MPC8266ADS its own platform. Instead of creating a
 > new platforms/ads8266.h header, ....

Will the "other issues to be addressed" cause the need for more definitions
or further #ifdefs in the existing file?  If so, let's just go ahead and
create the new file now and just add to it later.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
