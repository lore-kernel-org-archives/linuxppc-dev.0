Date: 6 Aug 2002 11:31:49 -0000
Message-ID: <20020806113149.3218.qmail@webmail7.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: "Michael Habermann" <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: CS_BAD_VCC Error during Card Configaration.
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

After i made the change to ignore mismatch in Vcc....my call to
cardservices(RequestIO) is
failing and the error returned is Resource in use.

But i neglected this failure and procedded..so now card is
configured and next failure
occured when i try to write to WLAN card register. In this case
Baseaddress returned
is 0 and i have done the modifications to add _IO_BASE to the base
address. (As mentioned
in mail archives).

what might be wrong for RequestIO failure??

Thanks,
Naren

On Mon, 05 Aug 2002 Michael Habermann wrote :
>Narendra wrote:
>>
>>But as i found through debug message, socket is configured for
>>5volts and the CIS read from my card wants 3.3V. So my
>>Config()
>>routine is failing since there is a mismatch in configured Vcc
>>and
>>Requested Vcc. and Kernel is crashing.
>>
>
>You are using a 3.3V card in an 5V socket. If the card can do
>this - and I think Prism 2 can - you  can bypass the code which
>checks if the Vcc is correct. You will maybe find it if you look
>in the WLAN drivers source code and search for conf.Vcc.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
