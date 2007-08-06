Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46B357D3.1040608@ru.mvista.com>
References: <20070730150648.GA5005@ru.mvista.com>	<20070801020836.GB31391@localhost.localdomain>	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B357D3.1040608@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <61ff959e035edf76fd5bc55306bb2a42@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 22:41:34 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +     - compatible : should contain the specific model of flash 
>> chip(s) used
>> +       followed by either "cfi-flash" or "jedec-flash"
>
>    Duh, have nearly forgotten to complain about "-flash" suffix.  
> Isn't it superfluous?

No, it describes what kind of thing this is.  "cfi" and "jedec"
don't say much: "cfi" could equally well mean the "cute friendly imp",
and who knows what kind of JEDEC-interface device this is supposed
to indicate.  "cfi-flash" and "jedec-flash" on the other hand are
sufficiently clear, even if they aren't completely specific; this
is a very common device so some leeway is in order.


Segher
