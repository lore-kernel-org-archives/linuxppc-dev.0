Message-ID: <3C94E3A8.9080301@embeddededge.com>
Date: Sun, 17 Mar 2002 13:42:48 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
References: <0203171816.AA01595@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> But if you don't specify the baud rate in any way, it'll default to 9600 except
> on the EV-64260-BP.

You haven't experienced enough of the universe :-).  Most boards default
to the setting provided by a boot rom.  Many of the boards I have use
115200 to speed up the embedded boot process but still allow debug output.

Maybe you guys working on these boards ought to discuss some common
solution instead of trying to use the "last patch changes the default
behavior" technique :-).

> That option works of course.

So, I don't see the problem.  A default is specified and you can change it,
just like lots of other configurations.

	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
