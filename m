Message-ID: <000701c2dffe$14ad8ac0$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <drow@false.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: FW: Improved copy_page() function, about 30% speed up for mpc860!
Date: Sat, 1 Mar 2003 15:23:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>On Fri, Feb 28, 2003 at 11:41:52AM +0100, Joakim Tjernlund wrote:
>>
>> Hi
>>
>> hmm, no reply on this on the embedded list. Maybe this list is a better place.
>
> I can't tell you what revs they were, but all of the MPC860's I could
> get my hands on here the last time I tried to use dcbz on them were
> faulty. You may just not be triggering the bug.

hmm, what boards was this?
I am planning to a larger test here with all our custom mpc860 and mpc862 boards. We have them in
100, 80 and 50 MHZ variants.

May be the bug is related to board design?  Is there an official errata from Motorla
regarding this bug? I can't find any.

Anyhow I had a flaw in my testprogram, so you can throw this version of copy_page() away.
But enabling the use of dcbz in the current version still gives me 30%+ performance increase.

See the embedded list for details.

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
