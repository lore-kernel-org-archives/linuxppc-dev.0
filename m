Message-Id: <v04003a06b353b65b1379@[204.22.210.180]>
In-Reply-To: <Pine.PMDF.3.96.990503135548.540345761G-100000@uni.edu>
References: <372D3AAD.3C76AF99@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 3 May 1999 16:32:19 -0400
To: puetzk6715@uni.edu
From: "sean o'malley" <somalley@ed.mde.state.mi.us>
Subject: Re: local.h header file.
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I found reference to MAX_OPEN_FILES in the SMB man pages so I would suspect
the Samba source would have local.h and the smb.conf file would have the
value MAX_OPEN_FILES


Sean



>Isn't this stuff in the kernel source?
>
>On Mon, 3 May 1999, Martin Costabel wrote:
>
>>
>> > Marc-AndrÈ Fortin wrote:
>> >
>> > Can somebody tell me if there is a file called local.h in RedHat Linux
>> > 5.2? (if yes, where it is?)
>> >
>> > Or maybe the parameter I'm looking for (MAX_OPEN_FILES) is somewhere
>> > else?
>> >
>> > Should I use the grep command to find files containing a specific
>> > string? Is (grep) looks in all the subdirectories?
>> > (I' tried, but no luck)
>>
>> To look for a string in all the *.h files in all subdirectories, you can
>> do
>>
>>    find . -name "*.h" -print | xargs grep MAX_OPEN
>>
>> or some abbreviation thereof (you can omit the '.' and '-print').
>>
>> I didn't find any local.h nor MAX_OPEN_FILES here, BTW.
>>
>> --
>> Martin
>>
>>
>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
