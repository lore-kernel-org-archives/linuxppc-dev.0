Message-ID: <403E0C74.6040508@embeddededge.com>
Date: Thu, 26 Feb 2004 10:10:44 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: challaharikumar <challaharikumar@tataelxsi.co.in>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC8272 Fast Ethernet Controller drver
References: <003201c3fc70$30a0ff20$3401080a@telxsi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


challaharikumar wrote:

> I want to know about the MPC8272 Fast Ethernet Controller. Is it same as
> MPC8260???
> In what way MPC8272 FCC differs from MPC8260.

The FCC is the same, the CPM is slightly different.

> Is there any Ethernet driver available for MPC8272 Fast Ethernet
> Controller??

There are some minor patches on the way into the source code, along
with updates to documentation errors in the manuals.  We caught all
of this while merging the existing 82xx CPM2 with the 85xx CPM2 into
common code.  Take a look at the ADS8272 configuration.

I don't know where the patches are in the pipeline.  I think the
linuxppc-2.4 in BitKeeper is current.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
