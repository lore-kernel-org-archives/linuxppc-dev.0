Message-ID: <3D0A6251.9040107@embeddededge.com>
Date: Fri, 14 Jun 2002 17:38:25 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dan Brennan <dmb8@optonline.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: compact flash and true IDE mode
References: <3D0A3DA4.586D0956@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Brennan wrote:

> ....Is anyone using CF in this
> mode? Any recommendations?

Yes, I see this quite frequently on products I help integrate.
You just need the right IDE board support functions to initialize
a few things and the standard IDE drivers "just work."  Take a look
at the work Matthew Locke did for the MPC8xx IDE.  If you find
yourself writing more than about 50 lines of total code in these few
setup functions, you're likely trying too hard :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
