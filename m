Date: 20 Aug 2000 22:28:17 -0500 
Subject: Re: MORE Mace on 7200 debug output, narrowing it down...
From: "Bruce Anderson" <brucea@spacestar.net>
To: "Robert E Brose II" <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <B5C60C05-111869@192.168.2.21>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Aug 14, 2000 12:52 AM, Robert E Brose II
<mailto:bob@kunk.jriver.com> wrote:
>User Bruce Anderson says:
>> On Wed, Aug 9, 2000 10:40 PM, Robert E Brose II
>> >Any ideas on what to look for next??
>>
>> Same tests but this time use a crossover and no hub between the
machines.
>
>Ok, had to wire up a crossover cable.
>It works "better" but still drops around 2 in 10 ping packets.
>
>IMPORTANT OBSERVATIONS:
>
>Whenever 7200 fails to reply to a packet, the packet has the P bit set.
>22:47:25.180000 > myeth0 > rhlinuxeth0: icmp: echo request
>22:47:25.180000 < rhlinuxeth0 > myeth0: icmp: echo reply (DF)
>22:47:26.180000 > myeth0 > rhlinuxeth0: icmp: echo request
>22:47:26.180000 P rhlinuxeth0 > myeth0: icmp: echo reply (DF)
>
>In the dump above, the first was successful, the second was not.
>
>Packet size makes very little difference (tried 64 to 1400 bytes)
>

I looked this over and did some testing with my 2.2.13 machine but
I do not have any machines at this time that can generate this error,
sorry.



" Stamp out root logins .  .  .  . su "   --Bruce Anderson
 This message was created and sent using Cyberdog 2.0, MacOS 8.6,
 awk, find, sed, sendmail, sh, and NetBSD a free Multi-Platform OS.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
