Subject: Re: MPC8560ADS issues
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Jason McMullan <jason.mcmullan@timesys.com>,
	Dan Malek <dan@embeddededge.com>
In-Reply-To: <C27D4FB6-73AE-11D8-A4B4-000393DBC2E8@motorola.com>
References: <1078945499.3748.4.camel@veena.timesys>
	 <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
	 <405090F3.1000900@embeddededge.com>
	 <1079025268.29565.51.camel@chuck.arlut.utexas.edu>
	 <C27D4FB6-73AE-11D8-A4B4-000393DBC2E8@motorola.com>
Content-Type: text/plain
Message-Id: <1079049197.5056.3.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 17:53:18 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-03-11 at 16:52, Kumar Gala wrote:
> I'm confused the gianfar driver is for the MPC8540 FEC.  I believe the
> initial question was regarding the FCC (on CPM / MPC8560).
>
> As to why your having poor performance on the MPC8540 FEC, that seems
> odd -- possibly some issue with the Intel PHY.  I do not believe we are
> seeing anything similar on the ADS.
>
> - kumar
>

My mistake, I did not realize the MPC8540 and MPC8560 were quite so
different. I just assumed too much, I apologize.

--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
