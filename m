Message-ID: <3893CE3D.99AACAB6@netx4.com>
Date: Sun, 30 Jan 2000 00:38:05 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Shuangjun Zhu <r44089@email.sps.mot.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Help about MPC823 Video and Cache
References: <002201bf6861$20f24d10$69f001dc@sjzhu.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shuangjun Zhu wrote:

> After the system boot up, the text on the TV flicker fiercely out,
> if I disable the I-Cache throught the EST visionProbe tool,

Determine your silicon revision and look on the Motorola web
site for errata and application notes.  Early versions of the
823 didn't work so well, especially at high resolution and
refresh rates.  Later versions of the 823 added somewhat
undocumented SIU configurations to improve the arbitration of
the U-bus and access to the frame buffer by the video controller.

If all seems well on the silicon front, make sure your video
configuration is proper.  Excessively high (and unnecessary)
refresh rates cause problems.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
