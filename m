In-Reply-To: <406AF8B3.6010002@embeddededge.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <406AF8B3.6010002@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6D144F40-8339-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org,
	Eugene Surovegin <ebs@ebshome.net>
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 12:32:47 -0500
To: Dan Malek <dan@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mar 31, 2004, at 11:58 AM, Dan Malek wrote:

>
> Eugene Surovegin wrote:
>
>> I wonder will it work on 4xx CPUs which don't have floating point
>> unit?
>
> It won't work on anything, will it?  Floating point isn't enabled for
> the kernel, unless I missed that update.
>

This code specifically handles this by enabling the FP bit in the MSR,
bypassing the standard floating point handling.  It saves the contents
of FP0, uses it, restores the contents, restores the MSR, and exits.

John


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
