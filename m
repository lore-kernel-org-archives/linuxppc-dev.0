Message-ID: <406AF8B3.6010002@embeddededge.com>
Date: Wed, 31 Mar 2004 11:58:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: John Whitney <johnw@sands-edge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Eugene Surovegin wrote:

> I wonder will it work on 4xx CPUs which don't have floating point unit?

It won't work on anything, will it?  Floating point isn't enabled for
the kernel, unless I missed that update.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
