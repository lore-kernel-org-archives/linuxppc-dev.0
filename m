Message-ID: <3D07A035.4090809@embeddededge.com>
Date: Wed, 12 Jun 2002 15:25:41 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: jon@eccincorp.com
Cc: Embedded Linux Forum <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Interrupt Latency
References: <3D0797F8.4030100@eccincorp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Baker wrote:


> ..... It would be nice if we could
> get the
> max under 50 us.  Or do you have to go to a real-time kernel?

Real-time != Real fast.......

Real-time indicates a predictable maximum/minimum, whatever is
appropriate for a given resource to be managed.  Since you asked
a question that implied a maximum interrupt latency requirement,
you are designing a real-time system.  Linux is not a real time
kernel, you will need to use something like RTLinux to meet such
requirements.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
